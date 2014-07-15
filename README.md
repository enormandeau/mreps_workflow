# mreps_workflow

Extract interesting microsatellite markers with mreps and format them into a
usable .tsv format

## Dependencies

### Linux

`mreps_workflow` has been tested on Linux (Ubuntu 12.04+). It may work on
MacOSX but has not been tested.

### mreps

Obviously, a copy of `mreps` is needed and must be installed on your computer.
A version of `mreps` is included with the workflow.

## Installation

`mreps_workflow` is installed with the following command:

```
sudo make install
```

You must have administrative rights on the computer where you wish to install
it. Alternatively, you can add the `mreps_workflow` directory to your `$PATH`
variable. Launch the following command in the terminal for a one-shot use or
add the same line to your `~/.bashrc` file to make the change persistent.

```
export PATH=/path/to/mreps_workflow:$PATH
```

### Testing the installation

To test the installation, move to the `mreps_workflow` directory and launch:

```
make test
```

## Use

Launching `mreps_workflow.sh` is done with the following command:

```
mreps_workflow.sh fasta_filename.fasta
```

## Contributions are welcome

If you find a bug or improve `mreps_workflow`, please contact the author.

