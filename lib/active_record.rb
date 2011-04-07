class ActiveRecord
    attr_accessor :id

    def initialize
        @id = self.class.new_increment

        self.class.register_instance(self)
    end

    def delete
        self.class.unregister_instance(self)
        @id = nil
    end


    class << self
        attr_reader :increment

        @instances

        def new_increment

            @increment += 1 unless @increment.nil?

            @increment ||= 1
        end

        def register_instance(instance)
            @instances ||= {}
            @instances[instance.id] = instance 
        end

        def unregister_instance(instance)
            @instances.delete(instance.id)
        end

        def get(id)
            @instances[id] rescue throw "No such object with such id" 
        end

        def count()
            @instances.length rescue 0
        end

        def find_by(filter = {})
            @instances.select do |id, instance|
                ok = true
                filter.each do |attr, value|
                    if ok && instance.send(attr) != value
                        ok = false
                    end
                end 
                ok
            end.values
        end

        def relation_one(class_name, attr, method_name)
            define_method method_name do
                Kernel.const_get(class_name).send :get, (instance_variable_get "@#{attr}")
            end
        end
        
        def relation_many(class_name, attr, method_name)
            define_method method_name do
                filter = {}
                filter[attr] = self
                Kernel.const_get(class_name).send :find_by, filter
            end
        end
        
        def dump()
            File.open("db/" + self.to_s + ".dump", "w") do |f|
                f.write Marshal.dump(@instances)
            end
        end
        
        def load()
            File.open("db/" + self.to_s + ".dump", "r") do |f|
                @instances = Marshal.load(f.read)
            end
        end
    end
end
