mapped = [x * x, where: x <- [1, 2, 3]]

filtered = [x, where: x <- [1, 2, 3], x > 1]

both = [x * y, where: x <- [1, 2, 3], y <- [4, 5, 6]]

with no where = [
    x <- [1, 2, 3]
    x * x
]

cartesian products = [
    x <- [1, 2, 3]
    y <- [4, 5, 6]
    [x, y]
]

async = [
    country code <- country codes
    country = http.get "/countries/#(country code)"!
    city name <- country.cities
    city = http.get "/cities/#(city name)"!
    city.population > population
    city
]
