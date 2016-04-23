require 'priority_queue'
 
class Graph
    def initialize()
        @vertices = {}
    end
  
    def add_vertex(name, edges)
        @vertices[name] = edges
    end
    
    def shortest_path(start, finish)
        maxint = (2**(0.size * 8 -2) -1)
        distances = {}
        previous = {}
        nodes = PriorityQueue.new
        
        @vertices.each do | vertex, value |
            if vertex == start
                distances[vertex] = 0
                nodes[vertex] = 0
            else
                distances[vertex] = maxint
                nodes[vertex] = maxint
            end
            previous[vertex] = nil
        end
        
        while nodes
            smallest = nodes.delete_min_return_key
            
            if smallest == finish
                path = []
                while previous[smallest]
                    path.push(smallest)
                    smallest = previous[smallest]
                end
                return path
            end
            
            if smallest == nil or distances[smallest] == maxint
                break            
            end
            
            @vertices[smallest].each do | neighbor, value |
                alt = distances[smallest] + @vertices[smallest][neighbor]
                if alt < distances[neighbor]
                    distances[neighbor] = alt
                    previous[neighbor] = smallest
                    nodes[neighbor] = alt
                end
            end
        end
        return distances.inspect
    end
    
    def to_s
        return @vertices.inspect
    end
end
 
g = Graph.new
g.add_vertex('0', {'1' => 4, '7' => 8})
g.add_vertex('1', {'2' => 8, '7' => 11})
g.add_vertex('2', {'8' => 2, '3' => 7, '5' => 4})
g.add_vertex('3', {'4' => 9})
g.add_vertex('4', {'5' => 10})
g.add_vertex('5', {'2' => 4, '3' => 14, '4' => 10, '5' => 2})
g.add_vertex('6', {'7' => 1, '5' => 2, '8' => 6})
g.add_vertex('7', {'0' => 8, '6' => 1, '1' => 11, '8' => 7})
g.add_vertex('8', {'2' => 2, '7' => 7, '6' => 6})
puts g.shortest_path('0', '8')

