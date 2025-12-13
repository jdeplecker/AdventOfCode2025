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

local parent = {}
local rank = {}

for n = 1,table_count(nodes) do
    parent[n] = n
    rank[n] = 0
end

local function find(node)
    if parent[node] ~= node then
        parent[node] = find(parent[node])
    end
    return parent[node]
end

local function union(node1, node2)
    node1 = find(node1)
    node2 = find(node2)
    if node1 == node2 then
        return false
    end

    if rank[node1] < rank[node2] then
        parent[node1] = node2
    elseif rank[node1] > rank[node2] then
        parent[node2] = node1
    else
        parent[node2] = node1
        rank[node1] = rank[node1] + 1
    end
    return true
end

local connections = {}

for n1_i = 1,table_count(nodes)- 1 do
    for n2_i = n1_i + 1,table_count(nodes) do
        table.insert(connections, {
            node1_i = n1_i,
            node2_i = n2_i,
            d = dist(nodes[n1_i], nodes[n2_i])
        })
    end
end

table.sort(connections, function(n1, n2) return n1.d < n2.d end)

local circuit_amount = table_count(nodes)

for _, connection in ipairs(connections) do
    if union(connection.node1_i, connection.node2_i) then
        circuit_amount = circuit_amount - 1
        if circuit_amount == 1 then
            print(nodes[connection.node1_i].x * nodes[connection.node2_i].x)
            break
        end
    end
end
