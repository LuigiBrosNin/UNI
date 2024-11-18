
import sys
import os

def move_attachments(md_folder, attachments_folder):
    
    # check if folders exist
    if not os.path.exists(md_folder):
        print(f'Folder {md_folder} does not exist')
        sys.exit(1)
    
    if not os.path.exists(attachments_folder):
        print(f'Folder {attachments_folder} does not exist')
        sys.exit(1)
        
    # get all files in the folder
    files = os.listdir(md_folder)
    
    # if there are other files that are not .md, ignore them
    files = [file for file in files if file.endswith('.md')]
        
    # iterate over files
    
    for file in files:
            
            # open file
            with open(os.path.join(md_folder, file), 'r') as f:
                
                # read file
                lines = f.readlines()
                
                # iterate over lines
                for line in lines:
                    
                    # check if line contains attachment
                    if "![[Pasted image " in line:
                        
                        # get attachment name
                        attachment_name = line.split('![[')[1].split(']]')[0]
                        
                        # check if there's a | in the name, if so get the first part
                        attachment_name = attachment_name.split('|')[0] if '|' in attachment_name else attachment_name
                        
                        # check if attachment exists
                        if not os.path.exists(os.path.join(attachments_folder, attachment_name)):
                            print(f'Attachment {attachment_name} does not exist')
                            continue
                        
                        # move attachment
                        os.rename(os.path.join(attachments_folder, attachment_name), os.path.join(md_folder+"/attachments", attachment_name))
                        
                        print(f'Moved attachment {attachment_name}')


if __name__ == '__main__':
    
    # get arguments
    if len(sys.argv) < 2:
        print('Usage: python move_attachments.py <folder with MD files to run trough> <folder with attachments to move, defaults to ./attachments>')
        sys.exit(1)
        
    md_folder = sys.argv[1]
    attachments_folder = sys.argv[2] if len(sys.argv) == 3 else './attachments'
    
    move_attachments(md_folder, attachments_folder)
    print('moved all attachments')
    sys.exit(0)