# PostgreSQL Deployment and Backup Setup

## Prerequisites
- **Control Node**: Linux-based OS (e.g., Ubuntu), Ansible installed, SSH access with administrative privileges.
- **Managed Node**: AWS Ubuntu instance (`worker01`), SSH access with administrative privileges.
- **Software**: Ansible installed on the control node.
- **Networking**: Control node must be able to reach the managed node over SSH (port 22).

## Steps

1. **Control Node Setup**
   - **Install Ansible**:
     ```bash
     sudo apt update
     sudo apt install ansible
     ```

2. **Managed Node Configuration**
   - **Ensure PostgreSQL Requirements**:
     PostgreSQL will be installed via the Ansible playbook, but make sure the managed node has basic connectivity and is accessible via SSH.

3. **Create Inventory File**
   - **Filename**: `inventory.ini`
   - **Content**:
     ```ini
     [worker01]
     worker01 ansible_host=<worker01-ip> ansible_user=<your-username>
     ```
     Replace `<worker01-ip>` with the IP address of the managed node and `<your-username>` with the SSH username.

4. **Deploy PostgreSQL and Configure Backup**
   - **Ansible Playbook**:
     - **Filename**: `deploy_database.yml`
     - **Description**: Automates the installation of PostgreSQL, sets up the database, creates a user, and configures a cron job for backups.
     - **Instructions**: Refer to the `deploy_database.yml` file in the repository for the exact content. Use the playbook to install PostgreSQL and configure backups.
       ```bash
       ansible-playbook -i inventory.ini deploy_database.yml
       ```

5. **Configure PostgreSQL Access**
   - **Jinja2 Template**:
     - **Filename**: `templates/pg_hba.conf.j2`
     - **Description**: Defines the PostgreSQL configuration file (`pg_hba.conf`) using Jinja2 templates to manage access controls dynamically.
     - **Instructions**: Refer to the `templates/pg_hba.conf.j2` file in the repository for the exact content. Update the PostgreSQL configuration using this template as needed.

6. **Backup Script**
   - **Filename**: `scripts/backup.sh`
   - **Description**: Performs the backup of the PostgreSQL database and is referenced in the cron job configured by the playbook.
   - **Instructions**: Refer to the `scripts/backup.sh` file in the repository for the exact content. Ensure this script is deployed to `/usr/local/bin/backup.sh` on `worker01` as part of the Ansible playbook.

# Output:
- ![image](https://github.com/user-attachments/assets/19737031-39d3-46c2-a873-b3a06b68b72b)
- ![image](https://github.com/user-attachments/assets/34098a70-307a-4587-8cb0-041dfc60fc18)
- ![image](https://github.com/user-attachments/assets/612c1659-d5b8-4d42-becc-e8d3a93b8a99)





## Summary

This setup ensures that PostgreSQL is installed and configured on `worker01`, with automatic backups handled by a cron job. Adjust the variables and file paths as necessary for your environment.

For detailed content and additional setup, please refer to the respective files in the repository.


