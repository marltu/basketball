class ActiveRecord
    attr_accessor :id

    def initialize()
        @id = self.class.new_increment

        self.class.register_instance(self)
    end

    def delete()
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


    end
end
