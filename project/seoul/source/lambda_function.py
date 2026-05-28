import json
import pymysql

def lambda_handler(event, context):
  connect = pymysql.connect(
      host=event['host'],
      user = event['user'], 
      passwd = event['password'], 
      db = event['db']
      )
  cursor = connect.cursor()
  file = open('db_init.sql', 'r', encoding = 'utf-8')
  read = file.read()
  lines = read.split(";")
  for line in lines:
      sql = line.strip().replace("\n", " ")
      if sql == "":
          continue
      cursor.execute(sql)
  return "Success"
