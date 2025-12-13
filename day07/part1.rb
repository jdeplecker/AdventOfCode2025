input_2d = []
File.read("day07/input.txt").split("\n").each do |line|
    input_2d.push line.split("")
end

width = input_2d[0].size
result = 0
for i in 1..input_2d.size - 1 do
    for j in 0..width - 1 do
        if input_2d[i][j] == "^"
            if (input_2d[i-1][j] == "|")
                result += 1
                if j > 0
                    input_2d[i][j - 1] = "|"
                end
                if j < (width - 1)
                    input_2d[i][j + 1] = "|"
                end
            end
        elsif input_2d[i][j] == "." && (input_2d[i-1][j] == "|" || input_2d[i-1][j] == "S")
            input_2d[i][j] = "|"
        end
    end
end

puts result