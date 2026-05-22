variable "lt_web"{
    type = object(
    {
	  name = string
	  description = string
	  image_id	= string
	  instance_type = string

	  iam_instance_profile = object(
	  {
	    name = string
	   }
	 )
    }
  )
}
variable "key_name" {
  description = "AWS 키페어 이름"
  type = string
}
variable "file_map" {
  type = map(object({
	key = string
  }))
}