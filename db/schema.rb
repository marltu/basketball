ActiveRecord::Schema.define :version => 0 do
    create_table :people do |t|
        t.string :name
        t.string :surname
    end

    create_table :team_members do |t|
        t.integer :person_id, :null => false
        t.integer :team_id, :null => false
        t.integer :number, :null => false
    end
    create_table :teams do |t|
        t.string :name
    end

    create_table :matches do |t|
        t.integer :team_home_id, :null => false
        t.integer :team_away_id, :null => false 
    end

    create_table :match_members do |t|
        t.integer :match_id, :null => false
        t.integer :team_member_id, :null => false
        t.string :team_type, :null => false
    end

    create_table :throws do |t|
        t.integer :match_member_id, :null => false
        t.integer :points, :null => false
        t.boolean :accurate, :null => false
    end

    create_table :fouls do |t|
        t.integer :match_member_id, :null => false
        t.integer :against_id 
    end
end
