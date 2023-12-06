import serial
import time
import os

def send_data_to_com(file_name, com_port, baud_rate):
    try:
        ser = serial.Serial(com_port, baud_rate, timeout=1)
        
        # Wait for a moment to ensure the port is open
        time.sleep(2)
        
        # Get the current script directory
        script_dir = os.path.dirname(os.path.abspath(__file__))

        # Form the complete path to the text file
        data_file_path = os.path.join(script_dir, file_name)

        with open(data_file_path, 'r') as file:
            # Read data from the file
            data = file.read()

            # Send data character by character with a delay of 1 second
            for char in data:
                ascii_value = ord(char)
                print(f"Sending character '{char}' with ASCII value {ascii_value}")
                ser.write(char.encode())
                time.sleep(2)

        # Close the COM port
        ser.close()
        print(f"Data sent successfully to {com_port} at {baud_rate} baud.")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    # Specify the name of the text file (assuming it's in the same directory)
    file_name = "your_file.txt"

    # Specify the COM port and baud rate
    com_port = "COM5"
    baud_rate = 9600

    # Call the function to send data to COM5
    send_data_to_com(file_name, com_port, baud_rate)
