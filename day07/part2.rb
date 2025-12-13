input_2d = []
File.read("day07/input.txt").split("\n").each do |line|
    input_2d.push line.split("")
end

width = input_2d[0].size

for j in 0..width - 1 do
    if input_2d[0][j] == "S"
        input_2d[0][j] = 1
    end
end

for i in 1..input_2d.size - 1 do
    for j in 0..width - 1 do
        if input_2d[i][j] == "^"
            if (input_2d[i-1][j] .is_a?(Integer))
                if j > 0 && input_2d[i][j - 1] == "."
                    input_2d[i][j - 1] = input_2d[i-1][j]
                elsif j > 0 && input_2d[i][j - 1].is_a?(Integer)
                    input_2d[i][j - 1] += input_2d[i-1][j]
                end
                if j < (width - 1)
                    input_2d[i][j + 1] = input_2d[i-1][j]
                end
            end
        elsif input_2d[i][j] == "." && input_2d[i-1][j].is_a?(Integer)
            input_2d[i][j] = input_2d[i-1][j]
        elsif input_2d[i][j].is_a?(Integer) && input_2d[i-1][j].is_a?(Integer)
            input_2d[i][j] += input_2d[i-1][j]
        end
    end
end

result = 0
for j in 0..width - 1 do
    if input_2d[-1][j].is_a?(Integer)
        result += input_2d[-1][j]  
    end
end
puts result