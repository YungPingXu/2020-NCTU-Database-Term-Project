with open("out", "w") as f:
    for i in reversed(range(1917, 1979)):
        print("<option value=\""+ str(i) + "\">"+ str(i) +"</option>",file=f)
