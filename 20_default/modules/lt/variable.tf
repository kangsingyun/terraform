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
	 user_data = string
    }
  )
}
variable "key_name" {
  description = "AWS 키페어 이름"
  type = string
}
