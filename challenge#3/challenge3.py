import json

object=(input("enter nested object: "))
key=(input("enter key: "))
dict_object=json.loads(object)

dict={}
n=0

for i in key.split("/"):
    if n == 0:
        dict=dict_object.get(i)
        n += 1
    else:
        dict=dict.get(i)
print("value = " + str(dict))
