import mysql.connector
import os

def admin_interface(cxn):
    cursor = cxn.cursor()
    print("\n------ Admin Interface ------")
    while True:
        print("\n1. Execute SQL Command")
        print("2. Execute SQL Script File")
        print("3. Logout")
        option = input("Please select one of the following options: ")

        if option == "1":
            try:
                command = input("Enter your SQL command: ")
                cursor.execute(command)
                if command.strip().lower().startswith("select"):
                    col_names = cursor.column_names
                    att_size = len(col_names)
                    for i in range(att_size):
                        print(col_names[i],4*'\t',end='')
                    print()
                    print(130 * '-')
                    rows = cursor.fetchall()
                    size = len(rows)
                    for i in range(size):
                        for x in range(len(rows[i])):
                            print(rows[i][x],end= 3*'\t')
                        print()
                    print()
                    
                else:
                    cxn.commit()
                    print("Command executed successfully!")
            except mysql.connector.Error as e:
                print(f"Error: {e}")

        elif option == "2":
            try:
                file_path = input("Enter the path to the SQL script file: ")
                if os.path.exists(file_path):
                    with open(file_path, "r") as file:
                        commands = file.read()
                        for command in commands.split(";"):
                            if command.strip():
                                cursor.execute(command)
                                cxn.commit()
                    print("SQL script executed successfully!")
                else:
                    print("File not found!")
            except mysql.connector.Error as e:
                print(f"Error: {e}")

        elif option == "3":
            print("Logging out.")
            break

        else:
            print("Invalid input. Please try again.")

def employee_interface(cxn):
    cursor = cxn.cursor()
    print("\n------ Employee Interface ------")
    while True:
        print("\n1. Lookup Data")
        print("2. Insert Data")
        print("3. Update Data")
        print("4. Delete Data")
        print("5. Logout")
        option = input("Select an option: ")

        if option  == "1":
            table = input("Enter the table name to lookup: ")
            field = input("Enter the field to filter by: ")
            value = input(f"Enter the value for {field}: ")
            try:
                query = f"SELECT * FROM {table} WHERE {field} = %s"
                cursor.execute(query, (value,))
                col_names = cursor.column_names
                att_size = len(col_names)
                for i in range(att_size):
                    print(col_names[i],3*'\t',end='')
                print()
                print(130 * '-')
                rows = cursor.fetchall()
                size = len(rows)
                for i in range(size):
                    for x in range(len(rows[i])):
                        print(rows[i][x],end= 2*'\t')
                    print()
                print()
                
            except mysql.connector.Error as e:
                print(f"Error: {e}")


        elif option == "2":
            table = input("Enter the table name for data insertion: ")
            method = input("Choose insertion method (1- File, 2- Manual): ")

            if method == "1":
                file_path = input("Enter the path to the data file: ")
                if os.path.exists(file_path):
                    with open(file_path, "r") as file:
                        for line in file:
                            values = tuple(line.strip().split(","))
                            try:
                                query = f"INSERT INTO {table} VALUES ({','.join(['%s'] * len(values))})"
                                cursor.execute(query, values)
                                cxn.commit()
                            except mysql.connector.Error as e:
                                print(f"Error: {e}")
                else:
                    print("File not found!")
            elif method == "2":
                try:
                    columns_query = f"SHOW COLUMNS FROM {table}"
                    cursor.execute(columns_query)
                    columns = [column[0] for column in cursor.fetchall()]
                    values = []
                    for column in columns:
                        value = input(f"Enter value for {column}: ")
                        values.append(value)
                    query = f"INSERT INTO {table} VALUES ({','.join(['%s'] * len(values))})"
                    cursor.execute(query, tuple(values))
                    cxn.commit()
                    print("Data inserted successfully!")
                except mysql.connector.Error as e:
                    print(f"Error: {e}")

        elif option == "3":
            table = input("Enter the table name to update: ")
            field = input("Enter the field to filter by: ")
            value = input(f"Enter the value for {field}: ")
            update_field = input("Enter the field to update: ")
            update_value = input(f"Enter the new value for {update_field}: ")
            try:
                query = f"UPDATE {table} SET {update_field} = %s WHERE {field} = %s"
                cursor.execute(query, (update_value, value))
                cxn.commit()
                if cursor.rowcount:
                    print("Update successful!")
                else:
                    print("No records found to update.")
            except mysql.connector.Error as e:
                print(f"Error: {e}")

        elif option == "4":
            table = input("Enter the table name to delete from: ")
            field = input("Enter the field to filter by: ")
            value = input(f"Enter the value for {field}: ")
            try:
                query = f"DELETE FROM {table} WHERE {field} = %s"
                cursor.execute(query, (value,))
                cxn.commit()
                if cursor.rowcount:
                    print("Deletion successful!")
                else:
                    print("No records found to delete.")
            except mysql.connector.Error as e:
                print(f"Error: {e}")

        elif option == "5":
            print("Logging out.")
            break

        else:
            print("Invalid choice. Please try again.")

def guest_interface(cxn):
    cursor = cxn.cursor()
    print("\n------ Guest Interface ------")
    while True:
        option = input("1. Browse All Art Pieces\n2. Browse Artists\n3. Browse Paintings\n4. Browse Sculptures/Statues\n5. Browse Other\n6. Browse Enhibitions\n7. Logout\nPlease choose an option: ")
        print()
        if option == "1":
            try:
                cursor.execute("SELECT * FROM art_object")
                col_names = cursor.column_names
                att_size = len(col_names)
                for i in range(att_size):
                    print(col_names[i],'\t',end='')
                print()
                print(130 * '-')
                rows = cursor.fetchall()
                size = len(rows)
                for i in range(size):
                    for x in range(len(rows[i])):
                        print(rows[i][x],end='\t')
                    print()
                print()
            except mysql.connector.Error as e:
                print(f"Error: {e}")

        elif option == "2":
            try:
                cursor.execute("SELECT * FROM artist")
                col_names = cursor.column_names
                att_size = len(col_names)
                for i in range(att_size):
                    print(col_names[i],'\t',end='')
                print()
                print(130 * '-')
                rows = cursor.fetchall()
                size = len(rows)
                for i in range(size):
                    for x in range(len(rows[i])):
                        print(rows[i][x],end='\t')
                    print()
                print()
            except mysql.connector.Error as e:
                print(f"Error: {e}")

        elif option == "3":
            try:
                cursor.execute("SELECT * FROM painting")
                col_names = cursor.column_names
                att_size = len(col_names)
                for i in range(att_size):
                    print(col_names[i],'\t',end='')
                print()
                print(100 * '-')
                rows = cursor.fetchall()
                size = len(rows)
                for i in range(size):
                    for x in range(len(rows[i])):
                        print(rows[i][x],end='\t')
                    print()
                print()
            except mysql.connector.Error as e:
                print(f"Error: {e}")

        elif option == "4":
            try:
                cursor.execute("SELECT * FROM sculpture_statue")
                col_names = cursor.column_names
                att_size = len(col_names)
                for i in range(att_size):
                    print(col_names[i],3*'\t',end='')
                print()
                print(130 * '-')
                rows = cursor.fetchall()
                size = len(rows)
                for i in range(size):
                    for x in range(len(rows[i])):
                        print(rows[i][x],end= 3*'\t')
                    print()
                print()
            except mysql.connector.Error as e:
                print(f"Error: {e}")

        elif option == "5":
            try:
                cursor.execute("SELECT * FROM other")
                col_names = cursor.column_names
                att_size = len(col_names)
                for i in range(att_size):
                    print(col_names[i],4*'\t',end='')
                print()
                print(130 * '-')
                rows = cursor.fetchall()
                size = len(rows)
                for i in range(size):
                    for x in range(len(rows[i])):
                        print(rows[i][x],end= 3*'\t')
                    print()
                print()
            except mysql.connector.Error as e:
                print(f"Error: {e}")

        elif option == "6":
            try:
                cursor.execute("SELECT * FROM exhibition")
                col_names = cursor.column_names
                att_size = len(col_names)
                for i in range(att_size):
                    print(col_names[i],6*'\t',end='')
                print()
                print(130 * '-')
                rows = cursor.fetchall()
                size = len(rows)
                for i in range(size):
                    for x in range(len(rows[i])):
                        print(rows[i][x],end= 3*'\t')
                    print()
                print()
            except mysql.connector.Error as e:
                print(f"Error: {e}")

        elif option == "7":
            print("Logging out.")
            break

        else:
            print("Invalid option. Please try again.")
        
def main():
    
    #connect to db
    cxn = mysql.connector.connect(
        host = "localhost",
        port = 3306,
        user = "root",
        password = "R3db8ll2121##",
        database = "museum"
    )
    if cxn.is_connected():
        print("Successfully connected to museum database.\n")
        while True:
            user_input = input("1. Admin\n2. Employee\n3. Guest\n4. Exit\nPlease select your user type: ")
            if user_input == "1":
                admin_interface(cxn)
                print("1 selected")
                print()
            elif user_input == "2":
                print("2 selected")
                employee_interface(cxn)
                print()
            elif user_input == "3":
                print("3 selected")
                guest_interface(cxn)
                print()
            elif user_input == "4":
                print("Exiting application.\n")
                break
            #default
            else:
                print("Invalid choice. Please try again.\n")
    else:
        print("Failed to connect to the database.")
    cxn.close()


if __name__ == "__main__":
    main()