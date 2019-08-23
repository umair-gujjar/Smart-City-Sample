    defn(`OFFICE_NAME')_simulated_cameras:
        image: smtc_sensor_simulation:latest
        environment:
            OFFICE: 'defn(`OFFICE_LOCATION')'
            DISTANCE: '20'
            SENSOR_ID: '{{.Task.Slot}}'
            DBHOST: 'http://ifelse(eval(defn(`NOFFICES')>1),1,defn(`OFFICE_NAME')_db,cloud_db):9200'
            FILES: '.mp4$$'
            THETA: 105
            MNTH: 75.0
            ALPHA: 45
            FOVH: 90
            FOVV: 68
            NO_PROXY: '*'
            no_proxy: '*'
        networks:
            - db_net
            - patsubst(defn(`OFFICE_NAME'),`office',`camera')_net
        deploy:
            replicas: 3
            placement:
                constraints: [ifelse(eval(defn(`NOFFICES')>1),1,node.labels.defn(`OFFICE_NAME')_zone==yes,node.role==manager)]
