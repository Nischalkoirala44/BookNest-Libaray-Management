<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    :root {
        --primary-color: #ff7a65;
        --primary-hover: #e66b58;
        --secondary-color: #f8f8f8;
        --text-color: #333;
        --light-text: #888;
        --border-color: #ddd;
    }

    .modal {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 1000;
        opacity: 0;
        visibility: hidden;
        transition: opacity 0.3s, visibility 0.3s;
    }

    .modal.active {
        opacity: 1;
        visibility: visible;
    }

    .modal-content {
        background-color: white;
        border-radius: 8px;
        width: 90%;
        max-width: 500px;
        max-height: 90vh;
        overflow-y: auto;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
    }

    .modal-header {
        padding: 15px 20px;
        border-bottom: 1px solid var(--border-color);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .modal-title {
        font-size: 20px;
        font-weight: bold;
    }

    .modal-close {
        background: none;
        border: none;
        font-size: 24px;
        cursor: pointer;
        color: var(--light-text);
    }

    .modal-body {
        padding: 20px;
    }

    .modal-footer {
        padding: 15px 20px;
        border-top: 1px solid var(--border-color);
        display: flex;
        justify-content: flex-end;
    }

    .modal-footer button {
        padding: 8px 15px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
        margin-left: 10px;
    }

    .modal-footer button a {
        text-decoration: none;
        color: white;
    }

    .btn-secondary {
        background-color: #f0f0f0;
        color: var(--text-color);
        border: 1px solid var(--border-color);
    }

    .btn-primary {
        background-color: var(--primary-color);
        color: white;
        border: none;
    }

    .profile-details {
        display: grid;
        grid-template-columns: 1fr 2fr;
        gap: 15px;
    }

    .profile-avatar {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        background-color: var(--primary-color);
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 36px;
        font-weight: bold;
        margin: 0 auto;
        overflow: hidden;
    }

    .profile-avatar img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 50%;
    }

    .profile-info {
        margin-top: 20px;
    }

    .profile-info-item {
        margin-bottom: 15px;
    }

    .profile-info-label {
        font-weight: bold;
        margin-bottom: 5px;
        color: var(--light-text);
        font-size: 14px;
    }

    .profile-info-value {
        font-size: 16px;
    }

    @media (max-width: 768px) {
        .profile-details {
            grid-template-columns: 1fr;
        }
    }
</style>

<!-- Profile Modal -->
<div class="modal" id="profileModal" role="dialog" aria-modal="true">
    <div class="modal-content">
        <div class="modal-header">
            <h2 class="modal-title">Profile</h2>
            <button class="modal-close">×</button>
        </div>
        <div class="modal-body">
            <div class="profile-details">
                <% model.User user = (model.User) session.getAttribute("user"); %>
                <% if (user != null) { %>
                <div class="profile-avatar">
                    <%= user.getProfilePicture() != null
                            ? "<img src='profilePicture?userId=" + user.getUserId() + "' alt='Profile Image' />"
                            : user.getName().charAt(0)
                    %>
                </div>
                <div class="profile-info">
                    <div class="profile-info-item">
                        <div class="profile-info-label">Name</div>
                        <div class="profile-info-value"><%= user.getName() %></div>
                    </div>
                    <div class="profile-info-item">
                        <div class="profile-info-label">Email</div>
                        <div class="profile-info-value"><%= user.getEmail() %></div>
                    </div>
                    <div class="profile-info-item">
                        <div class="profile-info-label">Bio</div>
                        <div class="profile-info-value"><%= Objects.toString(user.getBio(), "No bio provided") %></div>
                    </div>
                    <div class="profile-info-item">
                        <div class="profile-info-label">Address</div>
                        <div class="profile-info-value"><%= Objects.toString(user.getAddress(), "No address provided") %></div>
                    </div>
                </div>
                <% } else { %>
                <div class="profile-info">
                    <div class="profile-info-item">
                        <div class="profile-info-value">Please log in to view profile details.</div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn-secondary modal-close-btn">Close</button>
            <% if (user != null) { %>
            <button class="btn-primary"><a href="editProfile.jsp">Edit Profile</a></button>
            <% } %>
        </div>
    </div>
</div>

<script>
    // Modal Functionality
    const profileModal = document.getElementById('profileModal');
    const viewProfileBtn = document.getElementById('viewProfileBtn');
    const modalCloseBtns = document.querySelectorAll('.modal-close, .modal-close-btn');

    if (viewProfileBtn) {
        viewProfileBtn.addEventListener('click', function(e) {
            e.preventDefault();
            if (profileModal) {
                profileModal.classList.add('active');
                const userDropdown = document.getElementById('userDropdown');
                if (userDropdown) {
                    userDropdown.classList.remove('active');
                }
            }
        });
    }

    if (modalCloseBtns) {
        modalCloseBtns.forEach(btn => {
            btn.addEventListener('click', function() {
                if (profileModal) {
                    profileModal.classList.remove('active');
                }
            });
        });
    }

    if (profileModal) {
        profileModal.addEventListener('click', function(e) {
            if (e.target === this) {
                this.classList.remove('active');
            }
        });
    }
</script>