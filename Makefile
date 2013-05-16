nothing:

install:
	cp mreps_workflow.sh /usr/local/bin/mreps_workflow.sh
	cp mreps_preformat.py /usr/local/bin/mreps_preformat.py
	cp mreps_format_light.py /usr/local/bin/mreps_format_light.py

test:
	./mreps_workflow.sh test_data/454_test_sequences.fasta
