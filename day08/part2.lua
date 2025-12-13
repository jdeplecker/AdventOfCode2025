-- Might work but takes a long time
local input_lines = {}
for line in io.lines("day08/input.txt") do 
    input_lines[#input_lines + 1] = line
end

local nodes = {}
for _,line in pairs(input_lines) do
    for x, y, z in line:gmatch("(%d+),(%d+),(%d+)") do
        table.insert(nodes, {x=x, y=y, z=z})
    end
end

local function table_count(T)
  local count = 0
  for _,_ in ipairs(T) do count = count + 1 end
  return count
end

local function dist(node1, node2)
    return math.abs(node1.x - node2.x)^2 + math.abs(node1.y - node2.y)^2 + math.abs(node1.z - node2.z)^2
end

local function str(node)
    return string.format("%d %d %d", node.x, node.y, node.z)
end


local circuits = {}
local connections = {}
local node_names = {}

for _, n in ipairs(nodes) do
    local node_name = str(n)
    node_names[n] = node_name
    table.insert(circuits, {})
    table.insert(circuits[table_count(circuits)], node_name)
end

while table_count(circuits) > 1 do
    local smallest_dist = dist(nodes[1], nodes[2])
    local smallest_n1 = nodes[1]
    local smallest_n2 = nodes[2]
    for _, n1 in ipairs(nodes) do
        for _, n2 in ipairs(nodes) do
            if n1 == n2 then
                break
            end
            if dist(n1, n2) < smallest_dist and not (connections[string.format("%s %s", node_names[n1], node_names[n2])] == true) then
                smallest_dist = dist(n1, n2)
                smallest_n1 = n1
                smallest_n2 = n2
            end
        end
    end
    connections[string.format("%s %s", node_names[smallest_n1], node_names[smallest_n2])] = true
    connections[string.format("%s %s", node_names[smallest_n2], node_names[smallest_n1])] = true
    local n1_circuit_index = -1
    local n2_circuit_index = -1
    for c_num, circuit in ipairs(circuits) do
        for _, node_str in ipairs(circuit) do
            if node_str == node_names[smallest_n1] then
                n1_circuit_index = c_num
            end
            if node_str == node_names[smallest_n2] then
                n2_circuit_index = c_num
            end
        end
    end
    if not (n1_circuit_index == n2_circuit_index) then
        for _, node_str in ipairs(circuits[n2_circuit_index]) do
            table.insert(circuits[n1_circuit_index], node_str)
        end
        table.remove(circuits, n2_circuit_index)
    end
    if table_count(circuits) == 1 then
        print(smallest_n1.x * smallest_n2.x)
    end
end