from fpdf import FPDF
import os
from datetime import datetime


class PdfCreate:
    def __init__(self):
        self.pdf = FPDF()

    def add_step(self, step_name, screenshot_path):
        self.pdf.add_page()
        self.pdf.set_font("Arial", size=12)
        self.pdf.cell(200, 10, txt=f"Step: {step_name}", ln=True)
        if os.path.exists(screenshot_path):
            self.pdf.image(screenshot_path, x=10, y=20, w=190)

    def save_pdf(self, test_case_name):
        timestamp = datetime.now().strftime("%d_%m_%y_%H_%M")
        file_name = f"{test_case_name}_{timestamp}.pdf"
        full_path = os.path.join(f"C:/Users/14192/HelloPython/robot_test_project/Results/{file_name}")
        self.pdf.output(full_path)
        return full_path
