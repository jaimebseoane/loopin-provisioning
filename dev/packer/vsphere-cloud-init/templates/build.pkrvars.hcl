/*
    DESCRIPTION: 
    Build account variables used for all builds.
    - Variables are passed to and used by guest operationg system configuration files (e.g., ks.cfg, autounattend.xml).
    - Variables are passed to and used by configuration scripts.
*/

// Default Account Credentials
build_username           = "packer"
build_password           = "packer123"
build_password_encrypted = "$6$g/DJt7YCjSKsUg$gutLlIJSqHA0YNe30gN035r72vqVxmZGI0VYgLRF5wU2.erR8MzlhA3Uak3yGE.Q0zQqzJWaqts3RfXofVQ7T/"
build_key                = "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAHgGzSQN6sYrIkZgYhOB31575vxSHOYHAIQK9yrN/5uYrmcFP5zD2JyIazlFvWGHQdKhee29Nwk0u+4h8i8bl2P2QGAX20qmGAJlheZGrTneW8ZErXSesM+kphHt77GE5OYG/XZEQ8PgVYZ3Gf2XAUja2xdIuhCWLsUlPK2yUehA8LK1w== jseoane@jseoane-Virtual-Machine"