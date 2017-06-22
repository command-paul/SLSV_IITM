file = open("pk", 'rb')
byte = file.read(1)
while True:
	byte = file.read(4)
	if byte == b'' : break
	a = int.from_bytes(byte, byteorder='big', signed=False)
	print(format(a,'08x'))