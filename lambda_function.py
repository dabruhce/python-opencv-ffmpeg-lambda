import cv2

def lambda_handler(event, context):
	print "OpenCV installed version:", cv2.__version__
	fname = "./test.mpg"
	cam = cv2.VideoCapture(fname)
	print cam.isOpened()
	frameId = cam.get(1)
        ret, img = cam.read()
	imagesFolder = "/tmp"
	filename = imagesFolder + "/image_" + str(int(frameId)) + ".jpg"
	cv2.imwrite(filename, img)
	return "It works!"

if __name__ == "__main__":
	lambda_handler(42, 42)
