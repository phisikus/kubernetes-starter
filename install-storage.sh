#!/bin/sh

# Initialize base storage volume using shared directory
export KUBECONFIG=/etc/kubernetes/admin.conf
cat > storage.yaml <<EOF
kind: PersistentVolume
apiVersion: v1
metadata:
  name: storage-0
  labels:
    type: local
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/shared/storage"
EOF
kubectl create -f storage.yaml
rm storage.yaml
