#!/bin/bash
if pgrep -x llama-server > /dev/null; then
    echo "✅ Server is RUNNING"
    echo "PID: $(pgrep llama-server)"
    echo ""
    echo "Test with:"
    echo "curl http://localhost:8080/health"
else
    echo "❌ Server is NOT running"
    echo ""
    echo "Start with:"
    echo "nohup sh start_kimi.sh > kimi.log 2>&1 &"
fi
