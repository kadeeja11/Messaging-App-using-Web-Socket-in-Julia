module CreateTableMessages

import SearchLight.Migrations: create_table, column, columns, pk, add_index, drop_table, add_indices

function up()
  create_table(:messages) do
    [
      pk()
      columns([
        # :column_name => :column_type
        :Rid => :int
        :Sid => :int
        :msg => :string
      ])
    ]
  end
end

function down()
  drop_table(:messages)
end

end
