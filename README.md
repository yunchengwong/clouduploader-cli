# CLOUDUPLOADER-CLI

A bash-based CLI tool that allows users to quickly upload files to Google Cloud Storage, providing a seamless upload experience similar to popular storage services.

## PREREQUISITES

- **Google Cloud Account:** You must have a Google Cloud account with active billing. For more information, see [Create free account](https://www.googleadservices.com/pagead/aclk?sa=L&ai=DChcSEwjv4rag0YiHAxWL4RYFHelWBqoYABABGgJ0bA&co=1&ase=2&gclid=CjwKCAjwyo60BhBiEiwAHmVLJcA7TabY8sV7owWMwhfaBI9U_3A1qSMIimrhMpXi4HVE5Gx-oI-LjhoCo0wQAvD_BwE&ei=yheEZpDINLeF4-EPwvaCiAE&ohost=www.google.com&cid=CAESVeD2brbPcj_YXbA6und6jqaPM94VVZu70iyOdtc6jG8nz_HwuVI3QFrinlciXwXvocM485XEMkE9HPx8hmXk4bhd5ZSuS2M580J4Dw9ApjvAN3ZOnYo&sig=AOD64_2zm-TBrPQGuwtu9BNoMLZM2qPAlg&q&sqi=2&nis=6&adurl&ved=2ahUKEwiQ1ayg0YiHAxW3wjgGHUK7ABEQqyQoAHoECBEQDA).
- **Required Permissions:** To create and manage Cloud Storage resources, you need the Storage Admin (roles/storage.admin) IAM role for the project. During installation, sign in to the gcloud CLI with:
	- User credentials, or
	- A service account. For more information, see the "Setup & Authentication: (Optional) Service Account" section below.
- **Bash Environment:** Available on Linux/Unix, macOS, and Windows Subsystem for Linux.

## USAGE

```
clouduploader OBJECT [--bucket=BUCKET] [--storage-class=STORAGE_CLASS]
```

## INSTALLATION 

> **Note:** Only the files setup and clouduploader is required to perform simple upload to Google Cloud Storage

#### Step 1: Clone the repository

Using Git:

```
git clone https://github.com/yunchengwong/clouduploader-cli.git
cd clouduploader-cli
```

or

(Recommended) Using GitHub Codespaces (folder `.devcontainer` required):

![image](https://github.com/yunchengwong/clouduploader-cli/assets/48376163/864241a6-1df9-4a03-bf14-e2cbd49c7761)

#### Step 2: Make the Scripts Executable

```
chmod 755 setup clouduploader
```

#### Step 3: Run the Installation Script

```
./setup
```

#### Step 4: (Optional) Modify the `PATH` Variable

To run the program `clouduploader` without the `./` prefix, you need to add its path to your system's `PATH` variable.

**Temporary Solution:**

Run the following command in your shell terminal:

```
PATH=$PATH:$(pwd)
```

> **Note:** This change is temporary and will reset when you close the terminal.

**Permanent Solution:**

1. Copy clouduploader directory, ex. `/workspaces/username/clouduploader-cli/src`

2. Open your shell configuration file (`~/.bashrc`, `~/.zshrc`, etc.).

3. Add the following line:

```
export PATH=$PATH:<CLOUDUPLOADER_DIR>
```

4. Save the file and reload the shell configuration:

```
source ~/.bashrc  # or source ~/.zshrc
```

> **Note:** Editing the shell configuration file directly modifies your environment settings permanently. Ensure you have the necessary permissions and understand the changes being made.

## TROUBLESHOOTING

## REFERENCES (BY STEPS)

https://learntocloud.guide/phase1/

#### 1. Create a GitHub Repo: GitHub Codespaces

https://github.com/microsoft/bash-for-beginners

#### 2. Setup & Authentication: Google Cloud CLI

https://cloud.google.com/sdk/docs/install-sdk#installing_the_latest_version

```bash
# 1. Before you install the gcloud CLI, make sure that your operating system meets the following requirements:
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates gnupg curl

# 2. Import the Google Cloud public key.
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

# 3. Add the gcloud CLI distribution URI as a package source.
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# 4. Update and install the gcloud CLI:
sudo apt-get update && sudo apt-get install google-cloud-cli

# 5. Run gcloud init to get started:
gcloud init
```

#### 2. Setup & Authentication: (Optional) Service Account

https://www.cloudskillsboost.google/course_templates/49/labs/386466

1. create service account `clouduploader-storage-admin` with **Storage Admin** role
2. create and download a JSON key file in `clouduploader-storage-admin` > **KEYS**, rename it to `credentials.json`
3. upload `credentials.json` to `clouduploader-cli`

```
gcloud auth activate-service-account --key-file credentials.json
```

#### 3. CLI Argument Parsing

https://cloud.google.com/storage/docs/discover-object-storage-gcloud
https://cloud.google.com/sdk/gcloud/reference/storage

```bash
# Create a bucket
gcloud storage buckets create gs://my-awesome-bucket/ --uniform-bucket-level-access
gcloud storage buckets create gs://my-bucket --default-storage-class=nearline --location=asia

# Upload an object into your bucket
gcloud storage cp *.txt gs://my-awesome-bucket
gcloud storage cp --recursive dir gs://my-awesome-bucket

# List contents of a bucket or folder
gcloud storage ls
gcloud storage ls gs://my-awesome-bucket
gcloud storage ls --recursive gs://my-awesome-bucket
```

#### 7. Advanced Features: Provide an option to generate and display a shareable link post-upload.

https://cloud.google.com/storage/docs/access-control/making-data-public
https://cloud.google.com/storage/docs/uniform-bucket-level-access

```
gcloud storage objects update gs://BUCKET_NAME/OBJECT_NAME --add-acl-grant=entity=AllUsers,role=READER
```

#### 7. Advanced Features: Integrate encryption for added security before the upload.

https://cloud.google.com/storage/docs/encryption

> Cloud Storage always encrypts your data on the server side, before it is written to disk, at no additional charge.

#### 9. Distribution

https://stackoverflow.com/questions/8779951/how-do-i-run-a-shell-script-without-using-sh-or-bash-commands
