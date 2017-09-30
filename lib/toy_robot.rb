require "toy_robot/version"
require 'matrix'
require 'pry'


module CodeTable

    
    #Cardinal point angle
    NORTH = 0
    EAST = 90
    SOUTH = 180
    WEST = 270
    
    
    CARDINAL_POINT= { NORTH=> "NORTH", 
                      EAST=> "EAST", 
                      SOUTH=> "SOUTH", 
                      WEST=> "WEST"}
    
end


class Position
    attr_writer :direction
    attr_accessor :current
    def initialize(x,y,f)
        setpos(x,y,f)
    end
    
    def setpos(x,y,f)
        
        @direction = CodeTable.const_get(f.upcase)
        #TODO if direction n/a
        @current = Vector[x,y,@direction]
        
    end
    
end



class Robot
    attr_reader :position
    TABLE_W = 5 #x
    TABLE_H = 5 #y

    def place(x, y, f)
        
        if x > TABLE_W or y > TABLE_H
            raise RuntimeError, "Can not input value more than 5 because table size is 5 unit x 5 unit"
        end
        
        unless CodeTable::CARDINAL_POINT.values.include? f.upcase
            raise RuntimeError, "direction option:north,east,south,west"
        end
        
        @position = @position || Position.new(x.to_i,y.to_i,f)
        @position.setpos(x.to_i,y.to_i,f)
    end
    
    def report
        if defined? @position
        
            x =@position.current[0]
            y =@position.current[1]
            f =CodeTable::CARDINAL_POINT[@position.current[2]]
            
            return "#{x},#{y},#{f}"
    
        end
    end
    

    def left
        if defined? @position
            rotator = Vector[0,0,-90]
            @position.current = @position.current + rotator
            
            #reset to valid value that conforms to Cardinal Point angle in CodeTable
            if @position.current[2] == -90
                resetter = Vector[0,0,360]
                @position.current = @position.current + resetter
            end
        end
    end
    
    def right
        if defined? @position
            rotator = Vector[0,0,90]
            @position.current = @position.current + rotator
            
            #reset to valid value that conforms to Cardinal Point angle in CodeTable
            if @position.current[2] == 360
                resetter = Vector[0,0,-360]
                @position.current = @position.current + resetter
            end
        end
    end
    
    
    def move()
        if defined? @position
            
            adder = Vector[0,0,0]
            case @position.current[2]
            when CodeTable::NORTH
                if @position.current[1] == TABLE_H
                    puts "Already at the north edge of the table"
                else
                    adder = Vector[0,1,0]
                end
            when CodeTable::SOUTH
                if @position.current[1] == 0
                    puts "Already at the south edge of the table"
                else
                    adder = Vector[0,-1,0]
                end
            when CodeTable::EAST
                if @position.current[0] == TABLE_W
                    puts "Already at the east edge of the table"
                else
                    adder = Vector[1,0,0]
                end
            when CodeTable::WEST
                if @position.current[0] == 0
                    puts "Already at the west edge of the table"
                else
                    adder = Vector[-1,0,0]
                end
            else
                raise NotImplementedError
                
            end
            @position.current = @position.current + adder
        end
            
    end
    
end