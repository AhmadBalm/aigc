variable ports{
    type = list(number)
    default = [8080,8081,8082]
}

variable containers{
    type = map(object({
        external_port = number
    }))
    default = {
        abc = {
            external_port: 1234
        }
        xyz = {
            external_port: 9090
        }
    }
}

variable token {
    type = string
}