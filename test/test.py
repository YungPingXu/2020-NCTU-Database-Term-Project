with open("out", "w") as f:
    for i in reversed(range(1980, 2021)):
        print("<option value=\""+ str(i) + "\">"+ str(i) +"</option>",file=f)
