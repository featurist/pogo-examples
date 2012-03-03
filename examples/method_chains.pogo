list: map #i into @{
    i + 1
}: include #i where @{
    i < 5
}: each #i do @{
    console: log @i
}