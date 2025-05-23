from selenium import webdriver
from flask import Flask, request
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By
import os


app = Flask(__name__)

def download_selenium():
    chrome_options = webdriver.ChromeOptions()
    chrome_options.add_argument("--headless") 
    chrome_options.add_argument("--no-sandbox") 
    chrome_options.add_argument("--disable-dev-shm-usage") 
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=chrome_options)
    driver.get("https://google.com")
    title = driver.title
    pais = driver.find_element(By.XPATH,"/html/body/div[1]/div[6]/div/div[1]").text
    data = {"Page Title" : title, "Pais": pais}
    return data
    
@app.route('/ping')
def ping():
    return 'pong'    

@app.route('/', methods = ['GET','POST'])
def home():
    if (request.method == 'GET'):
        return download_selenium()


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))
    app.run(host="0.0.0.0", port=port)