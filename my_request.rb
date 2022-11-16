require 'csv'
require 'json'

class MySqliteRequest

    def initialize
        @type_of = :none
        @type_of_request = @type_of
        @selec  = []
        @select_columns = @selec
        @where_params    = []
        @insert_att = {}
        @insert_attributes = @insert_att
        @update_att = {}
        @update_attributes = @update_att 
        @table_name      = nil

    end

    def my_req_from(table_name_1)
        @table_name = table_name_1
        self
    end

    def my_req_select(columns)
        if(columns.is_a?(Array))
            @select_columns += columns.collect{ |elem| elem.to_s}
        else
            @select_columns << columns.to_s 
        end

        self._SetTypeOf(:select)
        self
    end

    def where_req(column_name_req, criteria_req)
        @where_params << [column_name_req, criteria_req]
        self
    end

    def insert_req(table_name)
        self._SetTypeOf(:insert)
        @table_name = table_name
        self
    end

    def values(data)
        if (@type_of_request == :insert)
            @insert_attributes = data
        else
            type_req()
        end
        self
    end

    def type_req()
        raise "Wrong type of request"
    end
    
    def print_select_type_1
        print_selects()
        puts "Where Attributes #{@where_params}"
    end

    def my_req_update(table_name)
        self._SetTypeOf(:update)
        @table_name = table_name
        self
    end


    def delete_req
        self._SetTypeOf(:delete)
        self
    end

   

    def print_selects() 
        puts "Select Attributes #{@select_columns}"
    end

    def print_insert_type_req
        puts "Insert Attributes #{@insert_attributes}"
    end

    def req_print()
        puts "Type Of Request #{@type_of_request.upcase}"
    end

    def print_req
        req_print()
        puts "Table Name #{@table_name}"
        if (@type_of_request == :select)
            print_select_type_1
        elsif 
            (@type_of_request == :insert)
            print_insert_type_req
        end
    end

    def run_request
        print_req
        if (@type_of_request == :select)
            _run_select_req
        elsif 
            (@type_of_request == :insert)
            _run_insert_my_req
        elsif 
            (@type_of_request == :update)
            _run_update_req_1
        elsif 
            (@type_of_request == :delete)
            _run_delete_requ        
        end
    end

    def _SetTypeOf(new_type_1)
        if (@type_of_request == :none or @type_of_request == new_type_1)
            @type_of_request = new_type_1
        else
            raise "Invalid: type of request already set to #{@type_of_request} (new type => #{new_type_1}) "
        end
    end

    

    def _run_select_req
        f = []
        result = f
        CSV.parse(File.read(@table_name), headers: true).each do |row_1|
            if @select_columns == ["*"]
                @select_columns=CSV.open(*@table_name,&:readline)
            end

            if @where_params==[]
                result << row_1.to_hash.slice(*@select_columns).values
            else   
            @where_params.each do |where_attribute|
                if row_1 [where_attribute[0]] == where_attribute[1]
                    result << row_1.to_hash.slice(*@select_columns).values
                end
            end
        end
    end
        puts @select_columns.to_csv
        result.each {|el|
        puts el.to_csv
        }
                
    end

    def _run_insert_my_req
        if @where_params ==[]

        File.open(@table_name, 'a') do|f|
           f.puts @insert_attributes.values.join(',')
        end

        else
            column_1 = @where_params[0][0]
            column_name = column_1
            pa_1 = @where_params[0][1]
            criteria = pa_1
            table_1 = CSV.table(@table_name)
            table = table_1 
            table.each do |row|
                if row[:"#{column_name}"]== criteria
                    @insert_attributes.each_pair {|key, value|
                    row[:"#{key}"] = value
                }
            end
        end
        File.open(@table_name, 'w') do |f|
            f.write(table.to_csv)
            end
        end
    
    end

    def _run_update_req_1
        req_1 = @where_params[0][0]
        column_name = req_1
        pa_1 = @where_params[0][1]
        criteria = pa_1
        a = CSV.table(@table_name)
        table = a
        table.each do |row|
            if row[:"#{column_name}"]==criteria
                @update_attributes.each_pair {|key,value|
                row[:"#{key}"]=value
            }
            end
        end
        File.open(@table_name, 'w') do |f|
            f.write(table.to_csv)
        end
    end

    def _run_delete_requ
        column = @where_params[0][0]
        column_name = column 
        criteria_req = @where_params[0][1]
        criteria = criteria_req
        table = CSV.table(@table_name)
        table.delete_if do|row_1|
            row_1[:"#{column_name}"] == criteria
        end
        File.open(@table_name,'w') do |f|
            f.write(table.to_csv)
        end
    end


end




 

 