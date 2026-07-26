variable "health_probes" {

  type = map(object({

    name = string

    loadbalancer_id = string

    protocol = string

    port = number

    interval_in_seconds = optional(number)

    number_of_probes = optional(number)

    request_path = optional(string)

  }))

}