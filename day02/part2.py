
def has_repeating_pattern(str_i):
    for pattern_size in range(len(str_i)//2, 0, -1):
        if str_i[:pattern_size] * (len(str_i)//pattern_size) == str_i:
            return True

    return False


result = 0
with open("day02/input.txt") as f:
    input = f.readline()
    ranges = input.split(",")
    for r in ranges:
        start, end = r.split("-")
        for i in range(int(start), int(end) + 1, ):
            str_i = str(i)
            if has_repeating_pattern(str_i):
                result += i
print(result)