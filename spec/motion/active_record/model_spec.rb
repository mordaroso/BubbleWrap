describe "Active Record - Model" do
  
  class Person < BW::Model
    has_many :cars
  end

  class Car < BW::Model
    belongs_to :person
  end

  describe "creation" do
    
    before do
      @cars = [Car.new, Car.new, Car.new]
      @name = "John"
      @surname = "Doe"
      @age = 22
      @person = Person.create(name: @name, surname: @surname, age: @age, cars: @cars)
    end

    it "should set the attributes from create arguments" do
      @person.name.should.equal @name
      @person.surname.should.equal @surname
      @person.age.should.equal @age
      @person.cars.should.equal @cars
    end

  end

  describe "finders" do
    
    it "handles both strings and hash arguments" do
      finders = -> {
        Person.find("name == 'John' AND surname == 'Doe'")
        Person.where("name == 'John' AND surname == 'Doe'")

        Person.find( { name: 'John', surname: 'Doe' } )
        Person.where( { name: 'John', surname: 'Doe' } )
      }
      finders.should.not.raise NoMethodError
    end

  end

  describe "saving / deleting" do
    
    before do
      @unique_name = 'efAEWFEWAfiuhwefb'
      @unique_surname = 'ewjfew3aWxcEWfse'
    end

    it "saves the object to the database" do
      person = Person.create(name: @unique_name, surname: @unique_surname)
      person.save

      Person.find(name: @unique_name, surname: @unique_surname).should.not.equal nil
      Person.where(name: @unique_name, surname: @unique_surname).should.not.equal nil
    end

    it "removes the object from the database" do
      person = Person.find(name: @unique_name, surname: @unique_surname)
      person.should.not equal nil
      person.delete
      Person.find(name: @unique_name, surname: @unique_surname).should.equal nil
      Person.where(name: @unique_name, surname: @unique_surname).should.equal nil
    end

  end

end