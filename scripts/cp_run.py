#!/usr/bin/env python3

import argparse
import xml.etree.ElementTree as ET
import os
import sh
import sys
import errno


class bcolors:
    HEADER = "\033[95m"
    OKBLUE = "\033[94m"
    OKGREEN = "\033[92m"
    WARNING = "\033[93m"
    FAIL = "\033[91m"
    ENDC = "\033[0m"
    BOLD = "\033[1m"
    UNDERLINE = "\033[4m"


def get_testcases(fp):
    with open(fp, "r") as f:
        lines = f.readlines()

    lines = list(map(lambda x: x.lstrip(), lines))
    lines = lines[lines.index("<testcases>\n") : lines.index("</testcases>\n") + 1]
    tree = ET.fromstring("".join(lines))

    testcases = []
    for test in tree.findall("test"):
        testcases.append(test.text.lstrip())

    return testcases


def get_args():
    parser = argparse.ArgumentParser(
        description="Run C++ or Python source file with testcases embedded in comments."
    )
    parser.add_argument("file", help="path to source file")
    parser.add_argument(
        "--no_pretty_print", action="store_true", help="Don't use colours in output"
    )
    parser.add_argument(
        "-t", help="testcase number to run (default: run all testcases)", type=int
    )
    args = parser.parse_args()
    return args


def get_run_command(fp):
    _, ext = os.path.splitext(fp)

    if ext == ".cpp":
        try:
            clangpp = sh.Command("g++")
            clangpp(fp, std="c++14", _fg=True)
        except sh.ErrorReturnCode as e:
            raise SystemExit()

        command = os.path.abspath(os.path.join(os.getcwd(), "a.out"))
        command = sh.Command(command)
    elif ext == ".py":
        command = sh.python.bake(fp)
    else:
        raise Exception("Unknown extension")

    return command


class Formatter:
    def __init__(self, pretty=True):
        if pretty:
            self.test_header = bcolors.HEADER + "--- Test {0} ---" + bcolors.ENDC
            self.warn_mssg = bcolors.WARNING + "{0}" + bcolors.ENDC
            self.fail_mssg = bcolors.FAIL + "{0}" + bcolors.ENDC
        else:
            self.test_header = "--- Test {0} ---"
            self.warn_mssg = "{0}"
            self.fail_mssg = "{0}"


if __name__ == "__main__":
    try:
        args = get_args()
        cmd = get_run_command(args.file)
        testcases = get_testcases(args.file)
    except:
        raise SystemExit()

    fmt = Formatter(not args.no_pretty_print)

    if len(testcases) == 0:
        print(fmt.warn_mssg.format("No testcases defined"))

    if args.t is not None:
        if args.t > len(testcases) or args.t <= 0:
            print(fmt.fail_msg.format(f"Test {args.t} not found"))

        print(fmt.test_header.format(args.t))

        try:
            cmd(_in=testcases[args.t - 1], _out=sys.stdout, _err=sys.stderr)
        except sh.ErrorReturnCode as e:
            print("Error:", e.exit_code)
            print(type(e).__name__.split('_')[1])
            pass

        raise SystemExit()

    for i, test in enumerate(testcases):
        try:
            print(fmt.test_header.format(i + 1))
            cmd(_in=test, _out=sys.stdout, _err=sys.stderr)
            print()
        except sh.ErrorReturnCode as e:
            print("Error:", e.exit_code)
            print(type(e).__name__.split('_')[1])
            pass
