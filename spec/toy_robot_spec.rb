require 'spec_helper'

describe ToyRobot do
    it 'has a version number' do
        expect(ToyRobot::VERSION).not_to be nil
    end

    it 'instantiate robot' do
        myr = Robot.new
        expect(myr).to be_a Robot 
    end
  
    it 'creates position' do 
        myr = Robot.new
        myr.place(2,3,"north")
        expect(myr.position).to be_a Position 
    end
    
    it 'raise error when invoke report but Robot#place not yet invoked' do
        myr = Robot.new
        myr.report
    end
    
    it '0,1,N' do 
        myr = Robot.new
        myr.place(0,0,"NORTH")
        myr.move
        expect(myr.report).to eq "0,1,NORTH"
    end
    
    it '0,0,W' do
        myr = Robot.new
        myr.place(0,0,"NORTH")
        myr.left
        expect(myr.report).to eq "0,0,WEST"
    end
    
    it '2,1,W' do
        myr = Robot.new
        myr.place(2,1,"EAST")
        myr.move
        myr.left
        myr.left
        myr.move
        expect(myr.report).to eq "2,1,WEST"
    end
    
    it '4,4,S' do
        myr = Robot.new
        myr.place(4,4,"SOUTH")
        myr.right
        myr.move
        myr.right
        myr.right
        myr.right
        expect(myr.report).to eq '3,4,SOUTH'
    end
    
    it '4,1,S' do
        myr = Robot.new
        myr.place(4,1,'WEST')
        myr.right
        myr.right
        myr.right
        myr.right
        myr.left
        expect(myr.report).to eq '4,1,SOUTH'
        
    end
    

    #test north edge    
    it '2,5,N' do
        myr = Robot.new
        myr.place(2,3,'WEST')
        myr.right
        myr.move
        myr.move
        myr.move
        expect(myr.report).to eq '2,5,NORTH'
    end
    
    #test east edge
    it '5,1,E' do
        myr = Robot.new
        myr.place(2,1,'EAST')
        myr.move
        myr.move
        myr.move
        myr.move
        expect(myr.report).to eq '5,1,EAST'
    end
    
    #test south edge
    it '2,0,S' do
        myr = Robot.new
        myr.place(2,2,'south')
        myr.move
        myr.move
        myr.move
        myr.move
        expect(myr.report).to eq '2,0,SOUTH'
    end
    
    #test west edge
    it '0,1,W' do
        myr = Robot.new
        myr.place(3,1,'west')
        myr.move
        myr.move
        myr.move
        myr.move
        expect(myr.report).to eq '0,1,WEST'

    end
    
    it 'raise error when direction is invalid' do
        myr = Robot.new
        expect { myr.place(2,4,'southwest') }.to raise_error(RuntimeError)
        
    end
    
    #test placement outside boundary
    it 'raise error when placing outside table width and size' do
        
        myr = Robot.new
        expect { myr.place(6,7,'north') }.to raise_error(RuntimeError)
    end
  
end
