# Copy this file to jenkins home directory/scripts and change project_id and private_token.
import json
import gitlab
import smtplib
import os
import argparse

parser = argparse.ArgumentParser()

parser.add_argument("--user",
                    help="User id of person responsible for the push.",
                    default=None,
                    dest="user_id")
parser.add_argument("--commits",
                    help="Commits in push",
                    default=None,
                    dest="commits")
parser.add_argument("--http",
                    help="Webb address of jenkins job, to be included in issue body.",
                    default=None,
                    dest="http")
parser.add_argument("--email",
                    help="Email address to send mail to if given",
                    default=None,
                    dest="email")
args = parser.parse_args()

module_dir = os.path.dirname(__file__)  # get current directory
file_path = os.path.join(module_dir, '../../../../my_scripts/credentials')

with open(file_path, 'r') as f:
    credentials = {}
    for line in f:
        fields = line.strip().split()
        credentials[fields[0]] = fields[1]

assignee_id = args.user_id
project_id = credentials['project_id']
private_token = credentials['private_token']
commits = json.loads(args.commits.replace("=>", ":"))
address = args.http


git = gitlab.Gitlab(credentials['gitlab'], token=private_token)

commits_text = ""
for c in commits:
    commits_text += "\n__Id:__ " + c['id'] + "\n\n__Message:__ " + c['message']+ "\n\n---"
title = "Build failed"
description = ("The build failed after push containing the following commits:\n\n---\n" +
               commits_text +
               "\n\nTo see output from build follow [this link](" + address + "console)."
               )

issue = git.createissue(project_id, title, description=description, assignee_id=assignee_id, labels='build_error,critical')

if args.email:
    TO = args.email
    SUBJECT = 'Build failed after last push - New issue created'


    # Gmail Sign In
    gmail_sender = credentials['gmail_sender']
    gmail_passwd = credentials['gmail_passwd']

    server = smtplib.SMTP('smtp.gmail.com', credentials['smtp_port'])
    server.ehlo()
    server.starttls()
    server.login(gmail_sender, gmail_passwd)

    BODY = '\r\n'.join(['To: %s' % TO,
                        'From: %s' % gmail_sender,
                        'Subject: %s' % SUBJECT,
                        '', description])

    try:
        server.sendmail(gmail_sender, [TO], BODY)
        print('email sent')
    except:
        print('error sending mail')

    server.quit()