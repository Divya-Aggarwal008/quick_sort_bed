import pandas as pd

run_df = pd.read_csv("data/runs_matadata.txt", header="infer", sep="\t")
sample_df = pd.read_csv("data/sample_matadata.txt", header="infer", sep="\t")
sel_df = pd.read_csv("data/selection.tsv", header="infer", sep="\t")

run_df.index = run_df["run"]
sample_df.index = sample_df["sample"]

def run_path_list_for_a_sample(wildcards):
	all_runs = sample_df.loc[wildcards.sample, "runs"].split(",")
	print(all_runs)
	run_path_list=[]
	for r in all_runs:
		path = run_df.loc[r, "file_path"]
		print(path)
		run_path_list.append(path)
	return run_path_list

rule selection_sort_for_a_sample:
	input:
		selection = "data/{selection}.tsv",
		run_path_list = lambda wildcards: run_path_list_for_a_sample(wildcards)
	output:
		result = "sorted_bed_file_per_sample/{sample}.{selection}.txt"
	shell:
		"sh script/selection_sorted.sh {input.selection} \"{input.run_path_list}\" {output.result}"
