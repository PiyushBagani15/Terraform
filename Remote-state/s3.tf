provider "aws"  {
region  =  "ap-south-1"
profile = "default"
}
resource "aws_s3_bucket" "b" {
  bucket = "my-tf-hello-tf-test-bucket"
  versioning {
		enabled = true #Enable versioning so that we can rollback to previous bucket content if needed
  }

	lifecycle { # meta-argument
		prevent_destroy = true #Ensure that this resource won't be destroyed at all
	}


}