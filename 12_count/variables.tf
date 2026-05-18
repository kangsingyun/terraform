variable "file_infos" {
  type = list(object(
    {
      content  = string
      filename = string
    }
  ))
}