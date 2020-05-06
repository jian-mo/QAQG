__author__ = 'Jian Mo'
import json


mode="dev"
file_path="squad_fr_"+mode+".json"

with open(file_path) as json_file:
    data_dict=json.load(json_file)
    print(data_dict["data"][0])

line_dict={"a":[],"q":[],"e":[]}

for value in data_dict["data"]:
    for p in value["paragraphs"]:
        e=p["context"]
        for qa_pair in p["qas"]:
            q=qa_pair["question"]
            answer_text=""
            for answers in qa_pair['answers']:
                answer_text=answers["text"]+" "+answer_text
            a=answer_text
            line_dict["a"].append(a)
            line_dict["e"].append(e)
            line_dict["q"].append(q)
            print(q)

for key,value in line_dict.items():
    with open(mode+"."+key+".fr.lc","w+",encoding="utf-8") as f:

        f.write("\n".join(value))