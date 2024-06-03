from flask import Flask, request, jsonify
from flask_cors import CORS
import google.generativeai as genai
import os

app = Flask(__name__)
CORS(app)


# 配置API密钥
genai.configure(api_key=os.environ['API_KEY'])

# 创建生成模型实例
model = genai.GenerativeModel(model_name='gemini-1.5-flash')


@app.route('/api/ai/generate', methods=['POST'])
def generate_content():
    data = request.json
    print(data)
    prompt = data.get('prompt')

    if not prompt:
        return jsonify({'error': 'Prompt is required'}), 400

    try:
        response = model.generate_content(prompt)
        return jsonify({'response': response.text})
    except Exception as e:
        return jsonify({'error': str(e)}), 500


# @app.route('/api/ai/updateAPI', methods=['PUT'])
# def update_api_key():
#     global model
#     data = request.json
#     os.environ['API_KEY'] = data.get('apiKey')
#     genai.configure(api_key=os.environ['API_KEY'])
#     model = genai.GenerativeModel(model_name='gemini-1.5-flash')
#     return jsonify({'message': 'API Key updated successfully'})


if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0')
