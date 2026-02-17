document.querySelectorAll('form').forEach(form => {
    form.addEventListener('submit', function (e) {
        const startTime = form.querySelector('input[name="startTime"]');
        const endTime = form.querySelector('input[name="endTime"]');
        if (startTime && endTime) {
            const start = new Date(startTime.value);
            const end = new Date(endTime.value);
            if (start >= end) {
                e.preventDefault();
                alert('End time must be after start time.');
            }
        }
    });
});

document.querySelectorAll('.delete-btn').forEach(button => {
    button.addEventListener('click', function (e) {
        if (!confirm('Are you sure you want to delete this shift?')) {
            e.preventDefault();
        }
    });
});

// Smooth fade-in for notifications
document.addEventListener('DOMContentLoaded', () => {
    const notifications = document.querySelector('.notifications');
    if (notifications) {
        notifications.style.opacity = '0';
        notifications.style.transition = 'opacity 0.5s ease';
        setTimeout(() => {
            notifications.style.opacity = '1';
        }, 100);
    }
});