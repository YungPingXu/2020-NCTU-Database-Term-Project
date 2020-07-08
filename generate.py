with open("out", "w") as f:
    for i in range(10, 201, 10):
        print("<option value=\""+ str(i) + "\">"+ str(i) +"</option>",file=f)
