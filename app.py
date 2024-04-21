import numpy as np
import mediapipe as mp
import math
import threading
from flask import Flask, jsonify, request
import os
import openai
import cv2 as cv
import multiprocessing
import speech_recognition as sr
import wave
import whisper
# import secretkey
import gtts
from playsound import playsound
from flask_cors import CORS
import time
import face_recognition
import os, sys
import cv2
import numpy as np
import math
import pymongo
import threading
import queue
from keras.utils import to_categorical
from keras.preprocessing.image import load_img
from keras.models import Sequential
from keras.layers import Dense, Conv2D, Dropout, Flatten, MaxPooling2D
import pandas as pd
from keras.models import model_from_json



model = whisper.load_model('base')

# Constants for audio recording
FORMAT = sr.AudioData
CHANNELS = 1
RATE = 22000
RECORD_SECONDS = 45  

recognizer = sr.Recognizer()

students = {}



mp_face_mesh = mp.solutions.face_mesh

app = Flask(__name__)
CORS(app)


interview_start_event = threading.Event()

eyePos = []
history = []
fillerWordsUsed = 0
count = 0
interviewDone = False
questionsForInterview = 1
openai.api_key = "sk-proj-mwLm3MVg8KZrYCIfTbrST3BlbkFJDYiyxjSz4El1iG2Iinby"
result = ''
def setResult(string):
    global result
    result = string

class chattingWork:

    interviewStart = 0

    def addUserConvo(self, message):
        conversation.append({"role": "user", "content": message})


    def addGPTConvo(self, response):
        conversation.append({"role": "user", "content": response["choices"][0]["message"]["content"]})

    def transcribe_audio(self, wav_file):
    # Initialize recognizer
        r = sr.Recognizer()
        # Load audio file
        with sr.AudioFile(wav_file) as source:
            audio = r.record(source)  # read the entire audio file

        # Recognize speech using Google Web Speech API
        try:
            print("Transcribing...")
            return r.recognize_google(audio)
        except sr.UnknownValueError:
            return "Google Web Speech API could not understand audio"
        except sr.RequestError as e:
            return f"Could not request results from Google Web Speech API; {e}"

    def runConvo(self):
        inti = 0
        global questionsForInterview
        global interviewDone
        global count
        global fillerWordsUsed
        global conversation
        global result
        interview_start_event.wait() 
        while True:
            count += 1 
            with sr.Microphone(sample_rate=RATE) as source:
                print("Recording...")
                audio = recognizer.listen(source)
            print("Recording stopped.")

            # Save the recorded audio to a WAV file
            with wave.open("assets2/shamzy.wav", 'wb') as wf:
                wf.setnchannels(CHANNELS)
                wf.setsampwidth(audio.sample_width)
                wf.setframerate(RATE)
                wf.writeframes(audio.frame_data)

            print("hello")

        
            result = self.transcribe_audio("assets2/shamzy.wav")
            setResult(result)
            print("Transcription: ", result)
            if(result != "Google Web Speech API could not understand audio"):
                break
            os.remove("assets2/shamzy.wav")
            # os.remove("assets2/bamzy.wav")


def face_confidence(face_distance, face_match_threshold=0.6):
    range = (1.0 - face_match_threshold)
    linear_val = (1.0-face_distance)/(range*2.0)

    if face_distance > face_match_threshold:
        return str(round(linear_val * 100, 2)) + '%'
    else:
        value = (linear_val + ((1.0 - linear_val) * math.pow((linear_val - 0.5) * 2, 0.2))) * 100
        return str(round(value, 2)) + '%'

class iris_recognition:

    cap = cv.VideoCapture(0)

    face_locations = []
    face_encodings = []
    face_names = []
    known_face_encodings = []
    known_face_names = []
    temp_students_present = []
    process_current_frame = True

    LEFT_IRIS = [474, 475, 476, 477]
    RIGHT_IRIS = [469, 470, 471, 472]

    L_H_LEFT = [33]     
    L_H_RIGHT = [133]  
    R_H_LEFT = [362]    
    R_H_RIGHT = [263]  

    def __init__(self) -> None:
        self.encode_faces()

    json_file = open("facialemotionmodel.json", "r")
    # json_file = open("fer.json", "r")

    model_json = json_file.read()
    json_file.close()
    model = model_from_json(model_json)

    model.load_weights("facialemotionmodel.h5")
    # model.load_weights("fer.h5")
    haar_file=cv2.data.haarcascades + 'haarcascade_frontalface_default.xml'
    face_cascade=cv2.CascadeClassifier(haar_file)

    def extract_features(self, image):
        feature = np.array(image)
        feature = feature.reshape(1,48,48,1)
        return feature/255.0


    def encode_faces(self):
        for image in os.listdir('assets'):
            face_image = face_recognition.load_image_file(f'assets/{image}')
            face_encoding = face_recognition.face_encodings(face_image)[0]

            self.known_face_encodings.append(face_encoding)
            self.known_face_names.append(image)
            name = image.split(".")[0]
            students[f'{name}'] = []
        # print(self.known_face_names)

    def euclidean_distance(self, point1, point2):
        x1, y1 =point1.ravel()
        x2, y2 =point2.ravel()
        distance = math.sqrt((x2-x1)**2 + (y2-y1)**2)
        return distance

    def iris_position(self, iris_center, right_point, left_point):
        center_to_right_dist = self.euclidean_distance(iris_center, right_point)
        total_distance = self.euclidean_distance(right_point, left_point)
        ratio = center_to_right_dist/total_distance
        iris_position =""
        if ratio >= 2.2 and ratio <= 2.7:
            iris_position = "right"
        elif ratio >= 2.95 and ratio <= 3.2:
            iris_position = "left"
        else:
            iris_position = "center"
        return iris_position, ratio
    
    def runFullIris(self):
        global interviewDone
        with mp_face_mesh.FaceMesh(max_num_faces=1, refine_landmarks=True, min_detection_confidence=0.5, min_tracking_confidence=0.5) as face_mesh:
            count = 0
            labels = {0 : 'angry', 1 : 'disgust', 2 : 'fear', 3 : 'happy', 4 : 'neutral', 5 : 'sad', 6 : 'surprise'}
            while True:
                if interviewDone:
                    gpt_thread.join()
                ret, frame = self.cap.read()
                if not ret:
                    break

                if(self.process_current_frame):
                    small_frame = cv2.resize(frame, (0,0), fx=0.25, fy=0.25)
                    rgb_small_frame = small_frame[:, :, ::-1]

                    self.face_locations = face_recognition.face_locations(rgb_small_frame)
                    self.face_encodings = face_recognition.face_encodings(rgb_small_frame, self.face_locations)

                    self.temp_students_present = []
                    self.face_names = []
                    for face_encoding in self.face_encodings:
                        matches = face_recognition.compare_faces(self.known_face_encodings, face_encoding)
                        name = 'Unknown'
                        confidence = 'Unknown'

                        face_distances = face_recognition.face_distance(self.known_face_encodings, face_encoding)
                        best_match_index = np.argmin(face_distances)

                        if matches[best_match_index]:
                            name = self.known_face_names[best_match_index]
                            #print(name)
                            confidence = face_confidence(face_distances[best_match_index])

                        self.face_names.append(f'{name.split(".")[0]} ({confidence})')
                        if(name != 'Unknown'):
                            self.temp_students_present.append(f'{name.split(".")[0]}')
                    #print(self.temp_students_present)
                count+=1
                
                self.process_current_frame = not self.process_current_frame
                gray=cv2.cvtColor(frame,cv2.COLOR_BGR2GRAY)
                for(top, right, bottom, left), name in zip(self.face_locations, self.face_names):
                    top *=4
                    right *=4
                    bottom *=4
                    left *=4

                    cv2.rectangle(frame, (left, top), (right, bottom), (0,0,255), 2)
                    cv2.rectangle(frame, (left, bottom - 35), (right, bottom), (0,0,255), -1)
                    cv2.putText(frame, name, (left+6, bottom-6), cv2.FONT_HERSHEY_DUPLEX, 0.8, (255, 255, 255), 1)
                    image = gray[top:bottom, left:right]
                    # cv2.rectangle(frame,(p,q),(p+r,q+s),(255,0,0),2)
                    cv2.rectangle(frame, (left, top), (right, bottom), (255, 0, 0), 2)
                    image = cv2.resize(image,(48,48))
                    img = self.extract_features(image)
                    pred = self.model.predict(img)
                    prediction_label = labels[pred.argmax()]
                    # print("Predicted Output:", prediction_label)
                    # cv2.putText(im,prediction_label)
                    cv2.putText(frame, '% s' %(prediction_label), (left-10, top-10),cv2.FONT_HERSHEY_COMPLEX_SMALL,2, (0,0,255))
                    # print(students[name.split(" ")[0]])
                    # print(prediction_label)
                    if(name.split(" ")[0] != 'Unknown'):
                        students[name.split(" ")[0]].append(prediction_label)
                    
                    # frame = cv.flip(frame, 1)
                    rgb_frame = cv.cvtColor(frame, cv.COLOR_BGR2RGB)  
                    img_h, img_w = frame.shape[:2]
                    results = face_mesh.process(rgb_frame)
                    if results.multi_face_landmarks:
                        mesh_points=np.array([np.multiply([p.x, p.y], [img_w, img_h]).astype(int) for p in results.multi_face_landmarks[0].landmark])

                        (l_cx, l_cy), l_radius = cv.minEnclosingCircle(mesh_points[self.LEFT_IRIS])
                        (r_cx,r_cy), r_radius = cv.minEnclosingCircle(mesh_points[self.RIGHT_IRIS])

                        center_left = np.array([l_cx, l_cy], dtype=np.int32)
                        center_right = np.array([r_cx, r_cy], dtype=np.int32)

                        cv.circle(frame, center_left, int(l_radius), (255, 0, 255), 1, cv.LINE_AA)
                        cv.circle(frame, center_right, int(r_radius), (255, 0, 255), 1, cv.LINE_AA)

                        cv.circle(frame, mesh_points[self.R_H_RIGHT][0], 3, (255, 255, 255), -1, cv.LINE_AA)
                        cv.circle(frame, mesh_points[self.R_H_LEFT][0], 3, (0, 255, 255), -1, cv.LINE_AA)

                        iris_pos, ratio = self.iris_position(center_right, mesh_points[self.R_H_RIGHT], mesh_points[self.R_H_LEFT][0])

                        # print(iris_pos)
                        # print(count)
                        count += 1
                    if count % 30 == 0 and count != 0:
                        eyePos.append(iris_pos)
                cv2.imshow("FaceRecognition", frame)
                key = cv.waitKey(1)
                if key ==ord("q"):
                    x = calcPercentage(eyePos, "center")
                    print("THE ACCURACY IS ", x , "%")
                    break
        self.cap.release()
        cv.destroyAllWindows()

def calcPercentage(arr, target):
    num = 0
    if len(arr) > 0:
        for x in arr:
            if x == target:
                num += 1
        return (num/len(arr)) * 100
    else:
        return 0


def runIris():
    ir = iris_recognition()
    ir.runFullIris()

def runGPT():
    gpt = chattingWork()
    gpt.runConvo()

def most_frequent(List):
    if len(List) == 0:
        return ''
    return max(set(List), key = List.count)


@app.route('/GetContactPercentage', methods = ['POST', 'GET'])
def getContactPercentage():
    try:
        return jsonify(float(round(calcPercentage(eyePos, "center"), 2))), 200
    except:
        return jsonify({'message': 'There was a problem getting the eye contact accuracy'}), 400



    
@app.route('/StartInterview', methods=['POST', 'GET'])
def startInterview():
    global conversation
    global count
    try:
        eyePos.clear()
        count = 0
        interview_start_event.clear()
        interview_start_event.set()  # Set the event to start the interview
        print("Interview started")
        return jsonify({'message': 'Interview was started'}), 200
    except:
        return jsonify({'message': 'There was a problem starting the interview'}), 400
    
@app.route('/EndConversation', methods=['POST', 'GET'])
def endConversation():
    global interviewDone
    try:
        interviewDone = True
        interview_start_event.wait()
        return jsonify({'message': 'Interview was ended', 'result': result}), 200
    except:
        return jsonify({'message': 'There was a problem ending the interview'}), 400

    
@app.route('/StartRecognizingEmotion', methods = ['POST', 'GET'])
def startRecognizingEmotion():
    try:
        for student in students:
            students[student].clear()
        return jsonify({'message': 'Start showing your emotion'}), 200
    except:
        return jsonify({'message': 'There was a problem starting the emotion recognition'}), 400

@app.route('/get_students', methods=['POST', 'GET'])
def get_students():

        try:
            studentFinal = {}
            for student in students:
                # print(students[student])
                # print(type(student))
                studentFinal[student] = most_frequent(students[student])
                print(most_frequent(students[student]))
            # List = []
            # print(max(set(List), key = List.count))
            return jsonify(studentFinal), 200
        except:
            return jsonify({'message': 'Object not found'}), 400



if __name__ == "__main__":
    flask_thread = threading.Thread(target=lambda: app.run(host='0.0.0.0', port=2516))
    gpt_thread = threading.Thread(target=runGPT)


    flask_thread.daemon = True
    gpt_thread.daemon = True

    gpt_process = multiprocessing.Process(target=runGPT)

    flask_thread.start()
    gpt_thread.start()
    runIris()