class Hello

    This_Is_A_Constant = 100

    def initialize(foo=0, bar=0)
        @foo = foo
        @@bar = bar
        print "foo: "; print @foo
        print "\nbar: "; print @@bar
    end 

    def helloworld
        puts "Hello World!\n"
        99
    end

    def m1
        100
        priv
        helloworld
        self.helloworld
        # self.priv ;; this will give an error since we cannot access private methods with self obj
        34
    end

    def m2
        @foo = 10 # @ represents instance variable; @@ represents class variables
        @@bar = 20
        print "Varibles!!\n"
        # This_Is_A_Constant += 1 ; this will give and error since we can't modify constants
        print This_Is_A_Constant 
    end

    def foo # getter method
        @foo
    end

    def foo= v # setter method
        @foo = v
    end

    # attr_accessor :foo, :bar ;; this is a method that creates getter and setter for foo, bar etc

private # all following methods will be private here after

    def priv
        puts "This is a private method\n"
    end
 
public

    def array
        ar = [1,2,3,4,5]
        print "\n"; ar.each {|i| puts (i*i)}
        print "\n"; ar.each {|x| puts x} # here x is an argument for the block.
    end

    def blocks
        # ruby programmers occationally use the loops. Instead they use blocks
        print "\n"; 3.times {print "hello,"}
        a = Array.new(5) {|i| i} # makes an array [0,1,2,3,4]
        print "\n"; print a
        print (a.any? {|x| x > 6}) # false
        print (a.any? {|x| x > 3}) # true
        # the stmnt below prints the sum of all elements of the array a
        print "\nArray-Sum : "; print (a.inject {|acc, elt| (acc+elt)}) # inject is the reduce function in ruby
        # we can also use 'do' and 'end' in blocks instead of '{' and '}'.
        # do and end are mainly used when we do multiple lines of block
    end

    # see how we can do complex things in ruby without using loops
    def no_loop_print_pattern i
        print "\n"
        (0..i).each do |j|
            print "  " * j
            (j..i).each {|k| print k; print " "}
            print "\n"
        end
    end

    # 'yield' keyword is used to access a block send to a function
    def silly a
        print (yield a)
    end

    # given below is how 'proc' can be used (proc is way better than block because it can take closures)
    def proc_sample
        [1,2,3,4,5].map { |x| (lambda {|y| x >= y}) }
    end

end

###############################################################################################################
# inheritance example
class Super
    attr_accessor :x

    def initialize
        @x = 1
    end

    def superfn
        print "\nInside superfn\n"
    end
end

class Sub < Super
    attr_accessor :y

    def initialize
        super()
        @y = 2
    end

    def subfn
        superfn
        print "Inside subfn\n"
        print "x: "; print @x; print "\n"
        print "y: "; print @y; print "\n"
        print "x: "; print x; print "\n"
        print "y: "; print y; print "\n"
    end
end

####################################################################################################################

x = Hello.new
x.helloworld
x.m1
x.m2
print "\n"; print Hello::This_Is_A_Constant # this is how constants are accessed outside class
print "\n"; print x.foo
x.foo = 23
print "\n"; print x.foo 
y = Hello.new(2, 3)
y.array
y.blocks
y.no_loop_print_pattern 9
print "\n"; y.silly(5) {|b| b*2}
print "\nProc_sample1: "; print y.proc_sample[3].call(12);
print "\nProc_sample2: "; print y.proc_sample[3].call(2);

# hashes
h1 = {"name"=>"amal", "age"=>22}
print "\n"; print h1

# ranges
r1 = 0..100
print "\n"; print r1

# subclassing
s = Sub.new()
s.subfn

###################################################################################################################

# we can create mixins in ruby using module keyword. mixins contains only methods and cannot be instantiated.
module Doubler
    def double
        self + self
    end
end

class Number
    attr_accessor :x, :y
    include Doubler # this is how we include a mixin
    def + other
        @x = 10
        self.x + other.x
        @y = "amal"
        self.y + other.y
    end
end

number = Number.new
print "\n****************\n"
print number.double; print "\n"

######################################################################################################################