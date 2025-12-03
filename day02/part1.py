
result = 0
with open("day02/input.txt") as f:
    input = f.readline()
    ranges = input.split(",")
    for r in ranges:
        start, end = r.split("-")
        for i in range(int(start), int(end) + 1, ):
            str_i = str(i)
            if len(str_i) % 2 == 0 and str_i[0:len(str_i)//2] == str_i[len(str_i)//2:]:
                result += i
print(result)