'''
Used to read SAS files for prior NHANES and create .csv file from
acquired information for use in R.
'''
def location_process(location_string):
    if '-' not in location_string:
        return 1
    
    else:
        numbers = location_string.split('-')
        difference = int(numbers[1]) - int(numbers[0])
        return difference+1


def decode_SAS(sas_file):
    word = 'INPUT'
    variable_flag = False
    found_space = False
    variable_list = list()
    location_list = list()
    variable_name = ''
    location_name = ''

    while True:
        letter = sas_file.read(1)

        if word == '': #once INPUT has been located
        
            if letter == ';': #signals the end of INPUT statement
                break
        
            elif variable_flag: #once a variable name has been located
                
                if found_space:
                
                    if letter != ' ' and letter != "\t" and letter != "\r" and letter != "\n":
                        location_name += letter
                    
                    else: #once end of variable initialization has been located
                        found_space = False
                        variable_flag = False
                        location = location_process(location_name)
                        location_list.append(location)
                        location_name = ''
                
                elif letter == ' ': #once a space separting name and location has been located
                    found_space = True
                    variable_list.append(variable_name)
                    variable_name = ''
                
                else:
                    variable_name += letter #rest of letters of variable
            
            elif letter != ' ' and letter != "\t" and letter != "\r" and letter !="\n":
                variable_name += letter #first letter of variable
                variable_flag = True
    
        elif letter == word[0]:
            word = word[1:]

        else:
            word = 'INPUT'

    return (variable_list, location_list)


def write_csv(raw_file_name, sas_file_name):
    raw_file = open(raw_file_name, 'r')
    sas_file = open(sas_file_name, 'r')
    R_data = open('dummy.txt', 'w')
    
    delimiter_info = decode_SAS(sas_file) #variable, location

    variables = delimiter_info[0]
    locations = delimiter_info[1]

    for i in range(0, len(variables)): #first row are variable names
        name = variables[i]
        R_data.write(name)

        if i != (len(variables)-1):
            R_data.write(',')
            
        else: #newline for last column
            R_data.write('\n')

    eof_flag = False
    
    while True:
        
        for i in range(0, len(locations)):
            length = locations[i]
            data = raw_file.read(length)

            if data == '': #end of file has been reached
                eof_flag = True
                break
            
            else:
                R_data.write(data)

                if i != (len(locations)-1):
                    R_data.write(',')
            
                else:
                    R_data.write('\n')

                    #read until newline has been reached
                    #problem when downloading directly from NHANES and downloading in R
                    #downloading directly gives '\r\n' at the end of a line
                    #downloading using R function download.file() gives '\n'
                    while raw_file.read(1) != '\n':
                        pass

        if eof_flag: #end of file; exit
            break
    
    raw_file.close()
    sas_file.close()
    R_data.close()


