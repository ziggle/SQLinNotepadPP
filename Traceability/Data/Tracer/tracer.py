"""
This script is intended to determine the completeness of
link coverage from one or more Polarion exported lists of
parent work items to one or more lists of child work items.
Author: Clayton Lewis
Date Modified: Sep. 30, 2021
"""

# %% Import Libraries

import argparse
import csv
import os
from textwrap import fill as textwrap_fill
import openpyxl

# %% Define Classes & Functions


class MultilineFormatter(argparse.HelpFormatter):
    """
    A wrapper class to provide selective formatting capabilities for
    ArgumentParser
    """
    def _fill_text(self, text, width, indent):
        text = self._whitespace_matcher.sub(' ', text).strip()
        paragraphs = text.split('|n ')
        multiline_text = ''
        for paragraph in paragraphs:
            formatted_paragraph = textwrap_fill(
                paragraph, width, initial_indent=indent, subsequent_indent=indent
                ) + '\n\n'
            multiline_text = multiline_text + formatted_paragraph
        return multiline_text


def file_read(infile, csv_dir=None):
    """Takes in the path to a list of .csv or .xlsx files and returns a list of the contents"""
    outfile = []
    for file_name in infile:

        # Convert .xlsx files to .csv files as needed
        if file_name.endswith('.xlsx'):
            xlsx_file = openpyxl.load_workbook(file_name).active
            file_name = os.path.splitext(os.path.basename(file_name))[0] + '.csv'
            if csv_dir is not None:
                file_name = os.path.join(csv_dir, file_name)
            with open(file_name, 'w', newline="") as new_csv_file:
                writer = csv.writer(new_csv_file)
                for row in xlsx_file.rows:
                    writer.writerow([cell.value for cell in row])

        with open(file_name) as csv_file:
            csv_read = csv.reader(csv_file)
            next(csv_read)  # Just cutting off the header
            csv_read = list(csv_read)

            # Append file name to end of each entry (this is how we record which doc these reqs came from)
            for entry in csv_read:
                entry.append(os.path.splitext(os.path.basename(file_name))[0])

            outfile.extend(list(csv_read))

    return outfile


def csv_writer(outfile_path, header, body):
    """
    Takes in the target file location as well as header and body text,
    then returns a .csv file at that location and with those contents
    """
    with open(outfile_path, 'w', newline='') as csv_file:
        writer = csv.writer(csv_file)
        writer.writerow(header)
        writer.writerows(body)


def has_link(parent_items, child_items):
    "Checks two lists of items for any link, returning true if at least one is found"
    parent_all_links = {link for _, _, _, links in parent_items if links != '' for link in links}
    child_all_ids = {child_id for child_id, _, _ in child_items}
    return bool(parent_all_links.intersection(child_all_ids))


def link_trim(parent_items, link_relation):
    """
    Trims provided list of parent items of any items without specified link type,
    returns trimmed list
    """
    parent_trimmed = []
    for parent_id, work_item_type, linked_work_items, doc_name in parent_items:
        link_ids = []
        if link_relation in linked_work_items:  # I'm not sure if checking list then checking items is faster
            for linked_work_item in linked_work_items.split(','):
                if link_relation in linked_work_item:
                    link_ids.append(linked_work_item.split(': ')[1])

            parent_entry = (parent_id, work_item_type, doc_name, tuple(link_ids))
            parent_trimmed.append(parent_entry)

    return parent_trimmed


def link_trace(parent_items, child_items):
    """
    Takes in a list/tuple of parent items and a list/tuple of children items,
    returns a list containing all traces
    """
    trace_completeness = []
    for parent_id, parent_item_type, parent_doc, parent_linked_items in parent_items:

        # For each Parent item's list of linked Children, loop through the Child items in search of a match
        for child_id, child_item_type, child_doc in child_items:

            # If any of the Parent's links match up with a Child in the list
            # then it's a matched req and we record the linkage
            if child_id in parent_linked_items and parent_linked_items != ['']:
                link_entry = (parent_id, parent_item_type, parent_doc, child_id, child_item_type, child_doc)
                trace_completeness.append(link_entry)

    return trace_completeness


def find_unmatched(items, trace_completeness):
    """
    Takes in a list of item tuples/lists and a list of traces, returning the untraced items
    as well as any additional information provided in the tuple/list as a list of lists
    """
    unlinked_items = []
    for item in items:
        if item[0] not in [elem for sublist in trace_completeness for elem in sublist] and item[0] != "":
            unlinked_items.append(item)

    return unlinked_items


def get_trace(parent_items, child_items, link_relation):
    """
    Wrapper function
    Takes in a list/tuple of parent items, a list/tuple of children items,
    and the parents' link relation to the children items. Returns None if
    there aren't any links, else 3 lists containing the detected traces,
    unlinked parents, and unlinked children
    """

    # Trim out everything that doesn't have a link of the right type
    parent_trimmed = tuple(link_trim(parent_items, link_relation))

    # Do a quick check to see if there are any links, returning them if found,
    # returning None if there aren't.
    if has_link(parent_trimmed, child_items):
        trace = link_trace(parent_trimmed, child_items)
        unlinked_parent_items = [(item_id, item_type, doc)
                                 for (item_id, item_type, _, doc) in find_unmatched(parent_items, trace)]
        unlinked_child_items = find_unmatched(child_items, trace)
        return trace, unlinked_parent_items, unlinked_child_items

    return None


# %% Handle Arguments
if __name__ == '__main__':

    print("Initializing")

    SCRIPT_SHORT_DESC = """
        This script is intended to determine the completeness of link coverage from
        one or more Polarion exported lists of parent work items to one or more
        lists of child work items
        """
    SCRIPT_LONG_DESC = """
        description:|n
        This script analyzes the provided files for links from the parent user
        items and compares them against the list of provided child items.|n

        The user must provide the desired lists (e.g. by using a file picker)
        by using the --input-(parent/child)-files arguments.|n
        File format (Parent/Child input files):|n
        [ID],[Type],[Document],[Linked Work Items],[_polarion]|n
        end help
        """

    ap = argparse.ArgumentParser(
        description=SCRIPT_SHORT_DESC, epilog=SCRIPT_LONG_DESC, formatter_class=MultilineFormatter
        )
    ap.add_argument("-p", "--input-parent-files", required=True, nargs='*', default=None,
                    help="the file(s) containing the parent work items")
    ap.add_argument("-c", "--input-child-files", required=True, nargs='*', default=None,
                    help="the file(s) containing the child work items")
    ap.add_argument("-o", "--outdir", required=True, default=None,
                    help="the filepath to the directory where results should be saved")
    ap.add_argument("--item-types", required=False, default=('User Requirement', 'System Requirement'),
                    help="the names of the work item types being analyzed\
                        (i.e. [\"User Requirement\", \"System Requirement\"])")
    ap.add_argument("--relation-type", required=False, default="is refined by",
                    help="the relationship of the child work item from the view of the parent\
                    (i.e. \"is refined by\")")
    args = ap.parse_args()

    print("Initialized")

    # %% Load Input Files
    print("Loading Files...")

    # Grab files
    parent_files = [os.path.realpath(file_name) for file_name in args.input_parent_files]
    child_files = [os.path.realpath(file_name) for file_name in args.input_child_files]

    # Read in files
    OUTPUT_DIR = os.path.realpath(args.outdir)
    parent_read = file_read(parent_files, OUTPUT_DIR)
    child_read = file_read(child_files, OUTPUT_DIR)

    print("Files loaded")

    # %% Reformat Input Lists
    print("Recombobulatinig files...")

    # The Parent linked items are messy and full of uninteresting things such as 'is branched from' so we want to
    # trim it down to just the argument-provided item types
    parent_read = [(id, work_item_type, links, doc_name) for id, work_item_type, live_loc, links, _, doc_name in
                   parent_read if work_item_type in args.item_types]

    # The Child list needs to be cut down to just the work item ID, type, and the document location
    # for all the items of the given work item type
    child_read = [(child_id, work_item_type, doc_name) for child_id, work_item_type, live_loc, _, _, doc_name in
                  child_read if work_item_type in args.item_types]

    print("Files recombobulated")

    # %% Check Link Completeness
    print("Analyzing linkage completeness...")

    # Check links looking downward
    output = get_trace(parent_read, child_read, args.relation_type)
    if output is None:
        print("""WARNING: No link detected between Parent and Child work items.
              Verify the correct input files were selected and that they have been formatted correctly.
              tracer closing...""")
        raise SystemExit
    (trace_links, unlinked_parents, unlinked_children) = output

    print("Analysis complete")

    # %% Write Output Files
    print("Writing results to files...")

    # Write files
    TRACE_OUTPUT_FILEPATH = os.sep.join((OUTPUT_DIR, 'trace.csv'))
    MISSING_CHILD_OUTPUT_FILEPATH = os.sep.join((OUTPUT_DIR, 'unlinked_child_items.csv'))
    MISSING_PARENT_OUTPUT_FILEPATH = os.sep.join((OUTPUT_DIR, 'unlinked_parent_items.csv'))

    TRACE_HEADER = ('Parent ID', 'Item Type', 'Parent Document',
                    'Child ID', 'Item Type', 'Child Document')
    MISSING_CHILD_HEADER = ('Child ID', 'Item Type', 'Child Document')
    MISSING_PARENT_HEADER = ('Parent ID', 'Item Type', 'Parent Document')

    csv_writer(TRACE_OUTPUT_FILEPATH, TRACE_HEADER, trace_links)
    csv_writer(MISSING_CHILD_OUTPUT_FILEPATH, MISSING_CHILD_HEADER, unlinked_children)
    csv_writer(MISSING_PARENT_OUTPUT_FILEPATH, MISSING_PARENT_HEADER, unlinked_parents)

    print("""
    Files written
    See results at:
    Completeness Trace:         {}
    Child items missing links:  {}
    Parent items missing links: {}
    """.format(TRACE_OUTPUT_FILEPATH, MISSING_CHILD_OUTPUT_FILEPATH, MISSING_PARENT_OUTPUT_FILEPATH))

    print("tracer closing...")
