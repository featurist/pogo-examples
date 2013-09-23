record = nil

try
    database = connect to the database!
    record := database.query!
catch (error)
    exit the program because of (error)!
finally
    database.close!

console.log("RECORD FOUND: #(record)")